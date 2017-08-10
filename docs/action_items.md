# Action Items
[Original Guide](https://github.com/activeadmin/activeadmin/blob/master/docs/8-custom-actions.md)

```ruby
action_item :convert, only: :show do
  # first argument for nav_btn is the text for the button
  nav_btn 'delete', '#'
end
```

```ruby
action_item :convert, only: :show do
  # first argument for nav_icon is the icon name from Material Design Icons - https://material.io/icons/
  nav_icon 'delete', '#'
end
```
