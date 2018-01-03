# classes_for_types

## NOTE: this is deprecated software

I wrote this back in 2008, for Rails 1.2 (if I recall correctly). Do not expect it to work nowadays.

## Introduction

`classes_for_types` is a plugin for Ruby on Rails.

In short. Take the following ERB code:

```
<%= f.text_field :title %>
```

*Without `classes_for_types`*, it renders as:

```
<input id="thing_title" name="thing[title]" size="30" type="text" />
```

*With `classes_for_types`*, it produces the following output:

```
<input class="text" id="thing_title" name="thing[title]" size="30" type="text" />
```

## A bit more of detail

This plugin simply adds a class name to tags that include a `type` attribute. The new class name is equal to the type. This is useful for styling forms, as some popular browsers do not have a CSS engine that supports attribute selectors.

Please note that this behaviour is not restricted to form-related elements. Any HTML element rendered using Rails's `tag()` helper will be affected. (This includes any standard Rails's helper that renders any tags whatsoever).

## License

This is free and unencumbered software released into the public domain. Do whatever you wish with it. See [LICENSE.txt](LICENSE.txt) for details.
