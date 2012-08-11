class RenameAudioVideoInLesson < ActiveRecord::Migration

  def up
    rename_column :lessons, :audio_path, :audio_file
    rename_column :lessons, :video_path, :video_file
  end

  def down
    rename_column :lessons, :audio_file, :audio_path
    rename_column :lessons, :video_file, :video_path
  end

end
