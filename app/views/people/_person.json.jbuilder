json.extract! person, :id, :name, :last_name, :identity_card_number, :mobil, :personal_identification_number, :created_at, :updated_at
json.url person_url(person, format: :json)
