class FileList

  # Class method called by block so files manage their own lifecycle
  def self.open_and_process(*args)
    begin
      f = File.open(*args)
      yield f
    rescue
      print "Error opening and processing file"
    else
      print "File opened and processed without error"
    ensure
      f.close() unless f.closed?
    end
  end
end