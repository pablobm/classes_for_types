require 'rubygems'          # Makes Rails's components require-able
require 'abstract_unit'     # Sets up a sane environment for testing within ActionView
require 'classes_for_types' # The actual file to test

ActionView::Helpers::TagHelper.send :include, ClassesForTypes::TagHelper
ActionView::Helpers::InstanceTag.send :include, ClassesForTypes::InstanceTag

