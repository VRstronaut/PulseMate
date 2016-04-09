class EmployeeCardController < ApplicationController
  def overview
  end

  def musco
  end

  def fatigue
  end

  def hydration
  end

  def mental
    @questions = [
      "I found it hard to  wind down",
      "I was aware of dryness of my mouth",
      "I couldn't seem to experience any positive feeling at all",
      "I experienced breathing difficulty",
      "I found it difficult to work up the initiative to do things",
      "I tended to over-react to situations",
      "I experienced trembling (eg, in the hands)",
      "I felt that I was using a lot of nervous energy",
      "I found myself in situations that made me so anxious I was most relieved when they ended",
      "I felt that I had nothing to look forward to",
      "I found myself getting agitated",
      "I found it difficult to relax",
      "I felt down-hearted and blue",
      "I was intolerant of anything that kept me from getting on with what I was doing",
      "I felt I was close to panic",
      "I was unable to become enthusiastic about anything",
      "I felt I wasn't worth much as a person",
      "I felt that I was rather touchy",
      "I was aware of the action of my heart in the absence of physical exertion",
      "I felt scared without any good reason",
      "I felt that life wasn't worthwhile",
    ]
  end

  def aod
  end

  ## POSTS

  def save_wellness
    depression_indices = %w(3 5 10 13 16 17 21)
    anxiety_indices =    %w(2 4 7  9  15 19 20)
    stress_indices =     %w(1 6 8  11 12 14 18)

    @depression = dass_intensity('depression', dass_sum(depression_indices))
    @anxiety = dass_intensity('anxiety', dass_sum(anxiety_indices))
    @stress = dass_intensity('stress', dass_sum(stress_indices))

    respond_to do |format|
      format.js
    end
  end

  private

  def dass_sum(indices)
    indices.reduce(0) do |score, idx|
      score + Integer(params[idx])
    end
  end

  def dass_intensity(type, sum)
    thresholds =
      case type # above this number but below next matches intensity
      when 'depression'
        [0, 5, 7, 11, 14]
      when 'anxiety'
        [0, 4, 6, 8, 10]
      when 'stress'
        [0, 8, 10, 13, 17]
      end

    intensities = %w(Normal Mild Moderate Severe) + ['Extremely severe']

    intensities.each_with_index do |intensity, idx|
      if thresholds[idx + 1]
        return intensity if sum >= thresholds[idx] && sum < thresholds[idx + 1]
      else
        return intensity
      end
    end
  end
end
