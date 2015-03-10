#!/bin/env ruby
# encoding: utf-8

module ChangesetPatch

  def self.included(base) # :nodoc:

    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :find_referenced_issue_by_id, :comment_allowed_for_user
    end

  end

  module InstanceMethods

    def find_referenced_issue_by_id_with_comment_allowed_for_user(id)
      return nil if id.blank?
      issue = Issue.find_by_id(id.to_i, :include => :project)
      if issue and user
        unless issue.project && user.allowed_to?(:add_issue_notes, issue.project)
          issue = nil
        end
      end
      issue
    end

  end

end