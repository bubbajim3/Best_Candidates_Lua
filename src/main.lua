-- Sample run
local function main()
  testVoter = {1, 1, 1, 0, 0, -1}
  testCandidates = {{"Clinton", 1, 1, 1, -1, 0, 0}, {"Trump", 0, 1, 1, -1, -1, -1}}
  show(best_candidates(testVoter, testCandidates))
end

-- Score candidate in respect to voter.
-- Returns their score
function scoreCandidate(voter, candidate)
  score = 0
  for i=1, #voter  do
    if(voter[i]==candidate[i+1] and voter[i]~=0) then
      score = score + 1
    elseif(voter[i]~=candidate[i+1] and voter[i]~=0 and candidate[i+1]~=0) then
      score = score - 1
    end
  end
  return score
end

-- Score all candidates
-- Returns array of {{Name, Score}, {Name, Score}...}
function scoreCandidates(voter, candidates)
  candidateScores = {}
  for i=1, #candidates do
    candidateScores[i] = {candidates[i][1], scoreCandidate(voter, candidates[i])}
  end
  return candidateScores
end

-- Finds the highest score amongst all candidates
function highestScore(candidateScores)
  score = candidateScores[1][2]
  for i=2, #candidateScores do
    if(candidateScores[i][2]>score) then
      score = candidateScores[i][2]
    end
  end
  return score
end

-- Retrieves the candidate(s) with the highest score
-- Returns an array of names only
function highestCandidates(score, candidateScores)
  candidates = {}
  for i=1, #candidateScores do
    if(candidateScores[i][2]==score) then
      candidates[#candidates+1] =  candidateScores[i][1]
    end
  end
  return candidates
end

-- Simple print helper
function show(candidates)
  for i=1, #candidates do
    print(candidates[i])
  end
end

-- Finds the best candidate(s) for a given Voter
-- Returns an array of candidate name(s)
function best_candidates(voter, candidates)
  candidateScores = scoreCandidates(voter, candidates)
  return highestCandidates(highestScore(candidateScores), candidateScores)
end

main()
