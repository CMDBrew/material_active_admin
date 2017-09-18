# Batch Action
[Original Guide](https://raw.githubusercontent.com/activeadmin/activeadmin/master/docs/9-batch-actions.md)

Added options are
```ruby
# when 'true' the button will be hidden on mobile window size and the button will be added to the dropdown list
@hidden_mobile = options[:hidden_mobile]
```

Example
```ruby
batch_action :action_1, hidden_mobile: true do
end
```

----

```ruby
# when 'true' the button will be added to the dropdown list
@dropdown_item = options[:dropdown_item]
```

Example
```ruby
batch_action :action_2, dropdown_item: true do
end
```
