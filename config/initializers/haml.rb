# Override module that will strip all whitespace from the HTML in production
module HamlCompacter
  def parse_tag(line)
    result = super(line)
    raise "Unexpected parse_tag output: #{result.inspect}" unless result.size == 9
    result[4] = true # nuke_outer_whitespace
    result[5] = true # nuke_inner_whitespace
    result
  end
end
# ["main", "", {}, :nil, nil, nil, nil, "", 1]):
Haml::Parser.send(:prepend, HamlCompacter) if ::Rails.env.production?
Haml::Template.options[:attr_wrapper] = '"'
