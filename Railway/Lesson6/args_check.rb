# Lesson6 (Railway)  Arguments Check Module
#
module ArgsCheck
  TRAIN_NUM_FORMAT = /^[\da-z]{3}-?[\da-z]{2}$/i

  protected

  def validate_string!(value)
    raise TypeError, "\tString expected" unless value.is_a?(String)
    raise ArgumentError, "\tEmpty string field is given" if value.empty?
  end

  def validate_num!(value)
    raise TypeError, "\tNumber expected" unless value.is_a?(Numeric)
    raise ArgumentError, "\tEmpty (zero) num field is given" if value.zero?
    raise ArgumentError, "\tPositive number expected" if value.negative?
  end

  def validate_format!(value)
    raise ArgumentError, "\tNumber field in wrong format is given" unless value =~ TRAIN_NUM_FORMAT
  end

  def validate_station_type!(value)
    raise TypeError, "\tStation object expected" unless value.is_a?(Station)
  end
end
