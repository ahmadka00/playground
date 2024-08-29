# frozen_string_literal: true

class BlogPostPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    @record.published? || @record.user == @user || (@user.present? && @user.admin?)
  end

  def create?
    new?
  end

  def new?
    @user.present?
  end

  def update?
    edit?
  end

  def edit?
    return false unless @user.present?

    @record.user == @user || @user.admin?
  end

  def destroy?
    edit?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      return @scope.published unless @user.present?

      return @scope.all if @user.admin?

      @scope.published.or(@scope.created_by(@user))
    end

    private

    attr_reader :user, :scope
  end
end
