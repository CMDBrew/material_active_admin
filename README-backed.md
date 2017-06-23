* [Button](#markdown-header-button)
* [Text Field](#markdown-header-text-field)

---

## Button

**Prefix Class:**

Elements must have this class for the styles to work
```scss
.mdi-btn
```

**Available Colors:**
```scss
$btn-color-map: (
  ".btn-default": $brand-default,
  ".btn-primary": $brand-primary,
  ".btn-success": $brand-success,
  ".btn-info":    $brand-info,
  ".btn-warning": $brand-warning,
  ".btn-danger":  $brand-danger
);
```
**Available Variations:**

Default button has type raised but you can add the classes below to change its appearance.
```scss
.btn-link
.btn-densed
```

**Ripple Effect:**

This will add on click rippled effect to the element
```scss
.with-ripple
```

**Input[type="submit"]**

Input[type="submit"] does not allow nested elements; therefore, you will need to apply the mdi-btn and color/variant classes to its parent.

eg.
```ruby
f.action :submit,
         :button_html  => {
           value: t('active_admin.devise.login.submit')
         },
         :wrapper_html => {
           :class             => "mdi-btn brand-primary with-ripple",
           :data_ripple_color => "rgba(0,0,0,.3)"
         }
```

**Advanced Usage**

You can also call the button-constructor mixin directly to style an button.

```scss
@mixin button-constructor(
  $color,
  $type:      raised,
  $size:      null,
  $parent_bg: $body-bg
)

```

| Variable       | Options        | Note                             |
| -------------- | -------------- | -------------------------------- |
| **$color**     | any colors     | HEX / RGBA                       |
| **$type**      | raised / link  | Determines the button appearance |
| **$size**      | null / densed  | Default is null, densed makes the button smaller |
| **$parent_bg** | any colors     | HEX / RGBA. This property only works for $type:link. It is used to determine the hover / focus background-color |

---

## Text Field

**Prefix Class:**

inputs' direct parent must have this class for the styles to work
```scss
.mdi-control
```

eg.
```ruby
f.input :email,
        :placeholder => "Email",
        :wrapper_html => {
          :class => "mdi-control with-guide"
        },
        :input_html  => { :autofocus => true }
```

**Available Variants**

Default text-field has type solid but you can add the classes below to change its appearance.
```scss
.with-guide
```

**Guide Color Options**

Add data attributes **guide-color** to change the active guide color.

eg.
```ruby
f.input :email,
        :placeholder => "Email",
        :wrapper_html => {
          :class => "mdi-control with-guide",
          :data  => { "guide-color" => "red" }
        },
        :input_html  => { :autofocus => true }
```

**Icon Label**

Add with-icon classes and add the icon to the label attribute to include an Icon

eg.
```ruby
f.input :email,
        :label       => content_tag(:i, "email", class: "cb_activeadmin-icons"),
        :placeholder => "Email",
        :wrapper_html => {
          :class => "mdi-control with-guide with-icon"
        },
        :input_html  => { :autofocus => true }
```

**Advanced Usage**

You can also call the text-field-contructor mixin directly to style an text-field.

```scss
@mixin text-field-constructor(
  $type:      solid,
  $size:      null,
  $color:     $brand-primary,
  $parent_bg: $body-bg
)
```

| Variable       | Options        | Note                             |
| -------------- | -------------- | -------------------------------- |
| **$color**     | any colors     | Default Guide Color. Only works for $type:guide  |
| **$type**      | solid / guide  | Determines the button appearance |
| **$size**      | null / densed  | Default is null, densed makes the text-field smaller |
| **$parent_bg** | any colors     | HEX / RGBA. This property is used to determine the guide / background-color |
