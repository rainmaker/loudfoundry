# loudfoundry.rb
require 'sinatra'

get '/' do
  max = File.read('max').to_f
  min = File.read('min').to_f
  prev = File.read('prev').to_f
  current = File.read('current').to_f

  if prev > current
    puts 'getting quieter...'
  else
    puts 'getting louder...'
  end

  how_loud_tho(relative_loudness(current, min, max))
end

put '/loudness' do
  puts "Params: #{params[:loudness]}"
  loudness = params[:loudness]

  record_loudness(loudness)
end

private

def relative_loudness(current, min, max)
  difference = max - min
  current_difference = current - min

  current_difference / difference
end

def record_loudness(loud)
  p = File.open('prev', 'w')
  p.write(File.read('current'))
  p.close

  c = File.open('current', 'w')
  c.write(loud)
  c.close

  if loud > File.read('max') || File.read('max') == ''
    m = File.open('max', 'w')
    m.write(loud)
    m.close
  end

  if loud < File.read('min') || File.read('min') == ''
    m = File.open('min', 'w')
    m.write(loud)
    m.close
  end
end

def how_loud_tho(r)
  if r > 0.8
    'hella loud'
  elsif r > 0.5
    'wicked loud'
  elsif r == 0.5
    'average loud'
  elsif r > 0.2
    'kinda quiet'
  else
    'so quiet wow'
  end
end
