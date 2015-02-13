# ---
# Concat is a module containing
# classes and methods used to combine
# text phrases and mp3 files into both a
# contiguous stream of text and mp3 data
# that contains audio for speaking the
# text aloud
# ---
module Concat

  class Statement
    ID3_HEADER_SIZE = 10
    attr_accessor :statement

    def initialize
      @statement ||= []
      # all text appended to an array of texts
      @paragraph ||= []
      # mp3 file audio concatenated
      # into an array of filenames
      @album ||= []
    end

    # concatenate text from each 
    # @statement into paragraph array
    def all_text
      @statement.each do |p|
         @paragraph << p.txt
       end
    end

    # This method will concat all mp3
    # filenames into the @album array
    def all_audio
      @statement.each do |p|
        @album  << p.fname
      end
    end

    # This method will output the completed mp3
    # data file/stream to the player on the client
    def speak
      true
    end

    private
    # ---
    # Get size of ID3 container.
    # Length is stored in 4 bytes, and the 7th bit of every byte is ignored.
    #
    # Example:
    #         Hex: 00       00       07       76
    #         Bin: 00000000 00000000 00000111 01110110
    #    Real bin:                        111  1110110
    #    Real dec: 1014
    # ---
    def get_id3_size(header)
      result = 0
      str = header[6..9]

      # Read 4 size bytes from left to right applying bit mask to exclude 7th bit
      # in every byte.
      4.times do |i|
        result += (str[i].ord & 0x7F) * (2 ** (7 * (3-i)))
      end

      result
    end

    def strip_mp3!(raw_mp3)
      # 10 bytes that describe ID3 container.
      id3_header = raw_mp3[0...ID3_HEADER_SIZE]
      id3_size = get_id3_size(id3_header)

      # Offset from which mp3 frames start
      offset = id3_size + ID3_HEADER_SIZE

      # Get rid of ID3 container
      raw_mp3.slice!(0...offset)
      raw_mp3
    end

    # This method will combine the data from each 
    # of the mp3 files in the Statement object into 
    # a single mp3 file/stream, ready for playback
    def process_audio
      # we want this array to hold binary mp3 data
      # there *may* be a better way to do this
      res = []
      @statement.each do |p|
        p.album.each do |mp3data|
          res << strip_mp3!(File.binread(mp3data.fname))
        end
      end
      File.binwrite('mp3out.mp3', res)
    end
  end
end
=begin
ID3_HEADER_SIZE = 10

# Get size of ID3 container.
# Length is stored in 4 bytes, and the 7th bit of every byte is ignored.
#
# Example:
#         Hex: 00       00       07       76
#         Bin: 00000000 00000000 00000111 01110110
#    Real bin:                        111  1110110
#    Real dec: 1014
#
def get_id3_size(header)
  result = 0
  str = header[6..9]

  # Read 4 size bytes from left to right applying bit mask to exclude 7th bit
  # in every byte.
  4.times do |i|
    result += (str[i].ord & 0x7F) * (2 ** (7 * (3-i)))
  end

  result
end

def strip_mp3!(raw_mp3)
  # 10 bytes that describe ID3 container.
  id3_header = raw_mp3[0...ID3_HEADER_SIZE]
  id3_size = get_id3_size(id3_header)

  # Offset from which mp3 frames start
  offset = id3_size + ID3_HEADER_SIZE

  # Get rid of ID3 container
  raw_mp3.slice!(0...offset)
  raw_mp3
end

# Read raw mp3s
hi   = File.binread('marriott.mp3')
bye  = File.binread('menu.mp3')
i    =  File.binread('i.mp3')
need = File.binread('need.mp3')
to   = File.binread('to.mp3')
go   = File.binread('go.mp3')
the  = File.binread('the.mp3')
bathroom = File.binread('bathroom.mp3')
now = File.binread('now.mp3')


# Get rid of ID3 tags
strip_mp3!(i)
strip_mp3!(need)
strip_mp3!(to)
strip_mp3!(go)
strip_mp3!(the)
strip_mp3!(bathroom)
strip_mp3!(now)

# Concatenate mp3 frames
i << need << to << go << to << the << bathroom << now

# Save result to disk
File.binwrite('mp3out.mp3', i)

res = `cvlc --play-and-exit mp3out.mp3`
end
=end


