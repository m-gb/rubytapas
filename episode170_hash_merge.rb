headers = <<END
Accept: */*
Set-Cookie: foo=42
Set-Cookie: bar=23
END

def parse_headers(headers)
  headers.lines.reduce({}) do |result, line|
    name, value = line.split(":")
    result.merge(name.strip => value.strip)
  end
end

  p parse_headers(headers)

# A better implementation might collect value of repeated headers into an array.
# We can supply an optional block to the #merge method. When there's a key collision, this block will be used to determine how to resolve it.

def parse_headers(headers)
  headers.lines.reduce({}) do |result, line|
    name, value = line.split(":")
    result.merge(name.strip => value.strip) {
      |key, left, right|                              #
      Array(left) + Array(right)
    }
  end
end
 
p parse_headers(headers)


accounting = {
    "burger" => 3,
    "cheesesteak" => 1,
    "veggie wrap" => 2
  }
  
  engineering = {
    "burger" => 2,
    "gyro" => 3
  }
  
  marketing = {
    "burger" => 1,
    "veggie wrap" => 2,
    "gyro" => 1
  }
  
order = [accounting, engineering, marketing].reduce({}) {
    |result, dept|
    result.merge(dept) {
        |key, left, right|
        left + right
    }
}
order
# => {"burger"=>6, "cheesesteak"=>1, "veggie wrap"=>4, "gyro"=>4}
  
#In the block we just ignore the right-hand value entirely(trance), and always use the left-hand one(drum&bass).
options = { genre: "drum&bass" }
full_options = options.merge(genre: "trance", bpm: 140){|_, left, _| left}
full_options
# => {:genre=>"drum&bass", :bpm=>140}

#  by passing a block to #merge, we can easily achieve any Hash-merging strategy we can think up.