class YamlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    YAML.load(value).with_indifferent_access
  rescue StandardError
    record.errors.add(attribute, options[:message] || :not_yaml)
  end

end
