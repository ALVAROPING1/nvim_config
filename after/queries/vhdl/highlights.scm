;; extends

(_
  type: (name (selection (identifier) @type)))

(instantiated_unit
  entity: (name (selection (identifier) @module)))

((identifier) @constant
    (#has-ancestor? @constant association_or_range_list)
    (#has-ancestor? @constant subtype_indication))

(library_type) @type

(attribute "'" @keyword.operator)

(_
  architecture: (identifier) @method)

