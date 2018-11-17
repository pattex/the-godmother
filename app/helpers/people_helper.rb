module PeopleHelper
  def tags
    Tag.where(active: true).map { |t| html_escape(t.name) }
  end
end
