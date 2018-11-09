module PeopleHelper
  def tags
    Tag.where('active = 1').map { |t| html_escape(t.name) }
  end
end
