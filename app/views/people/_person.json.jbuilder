json.extract! person, :id, :link, :name, :pronoun, :email, :about, :special_needs, :created_at, :updated_at
json.url person_url(person, format: :json)
