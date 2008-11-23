require 'classes_for_types'

ActionView::Helpers::TagHelper.send :include, ClassesForTypes::TagHelper
ActionView::Helpers::InstanceTag.send :include, ClassesForTypes::InstanceTag

