class DassMetric
  INTENSITIES = %w(Normal Mild Moderate Severe) + ['Extremely severe']
  attr_reader :type, :index, :intensity

  def initialize(type, sum)
    thresholds =
      case type # above this number but below next matches intensity
      when 'depression'
        [0, 5, 7, 11, 14]
      when 'anxiety'
        [0, 4, 6, 8, 10]
      when 'stress'
        [0, 8, 10, 13, 17]
      end

    intensity_index = (0..4).each do |idx|
      if thresholds[idx + 1]
        break idx if sum >= thresholds[idx] && sum < thresholds[idx + 1]
      else
        break idx
      end
    end

    @type = type
    @index = intensity_index
    @intensity = INTENSITIES[index]
    freeze
  end

  def to_s
    @intensity + ' ' + @type
  end

  def normal?
    @index == 0
  end

  def extreme?
    @index >= 3
  end
end
