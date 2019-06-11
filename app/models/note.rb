class Note < ApplicationRecord
	include NoteEnum
	belongs_to :accord
end
