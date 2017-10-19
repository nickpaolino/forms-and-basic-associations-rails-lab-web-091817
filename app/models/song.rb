class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name=(arg)
    self.artist = Artist.find_or_create_by(name: arg)
  end

  def notes=(notes)
    notes.each do |note|
      note = Note.create(content: note)
      self.notes << note if !note.content.empty?
    end
  end

  def genre_name=(genre_name)
    self.genre = Genre.find_or_create_by(name: genre_name)
  end

  def genre_name
    self.genre.name
  end

  def artist_name
    self.artist.name
  end

  def note_contents=(notes)
    notes.each do |content|
      if content.strip != ''
        self.notes.build(content: content)
      end
    end
  end

  def note_contents
    self.notes.map(&:content)
  end
end
