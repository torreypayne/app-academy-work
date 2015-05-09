require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    # Needs to link to the ONE middle association that links to ONE further assoc.
    option1 = belongs_to(through_name.to_s.constantize.source_name)
    # ...
  end
end
