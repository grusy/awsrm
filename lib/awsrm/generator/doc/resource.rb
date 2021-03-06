module Awsrm
  module Generator
    module Doc
      class Resource
        class << self
          def generate_doc
            inflector = Dry::Inflector.new
            resource_dir = __dir__ + '/../../resources/'
            resources = Dir.glob(resource_dir + '*').map do |file|
              File.basename(file, '.rb')
            end
            resources.sort!
            links = resources.map do |r|
              '[' + inflector.classify(r) + '](#' + r + ')'
            end
            header = <<-'EOF'
# Resources

<%= links.join("\n| ") %>

EOF
            doc = ERB.new(header, nil, '-').result(binding)
            resources.each do |r|
              filter_map = Object.const_get("Awsrm::#{inflector.classify(r)}::FILTER_MAP")
              doc += ERB.new(resource_template, nil, '-').result(binding)
            end
            doc
          end

          def resource_template
            template = <<-'EOF'
## <a name="<%= r %>">Awsrm::<%= inflector.classify(r) %></a>

### Filter

| key | replaced filter |
| - | - |
<% filter_map.each do |k, v| %>| <%= k %> | <%= v.is_a?(Proc) ? '[`#<Proc>`](https://github.com/k1LoW/awsrm/blob/master/lib/awsrm/resources/' + r + '.rb)' : '`' + v + '`' %> |
<% end %>

EOF
            template
          end
        end
      end
    end
  end
end
