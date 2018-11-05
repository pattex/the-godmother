module PeopleHelper
  def tags
    Tag.all.map { |t| html_escape(t.name) }
  end
end
