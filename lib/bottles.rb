class Bottles
    def song()
        <<-VERSES
#{self.verse_repeat(99, 0)}
VERSES
    end

    def verses(high, low)
        <<-VERSES
#{self.verse_repeat(high, low)}
VERSES
    end

    def verse(number)
        <<-VERSE
#{self.verse_without_header(number)}
VERSE
    end

    def verse_repeat(high, low)
        c = ''
        (low..high).reverse_each do |bottle|
            c = c + "#{self.verse_without_header(bottle)}"
            if (bottle > low) then
                c = c + "\n\n"
            end
        end
        c
    end

    def verse_without_header(number)
        "#{self.bottles_on_the_wall_start(number)} of beer on the wall, #{self.bottles_on_the_wall_end(number)} of beer.\n#{self.take_bottle(number)}, #{self.bottles(number - 1)} of beer on the wall."
    end

    def bottles_on_the_wall_start(number)
        if (number == 0) then
            'No more bottles'
        elsif (number == 1) then
            '1 bottle'
        else
            "#{number} bottles"
        end
    end

    def bottles_on_the_wall_end(number)
        if (number == 0) then
            'no more bottles'
        elsif (number == 1) then
            '1 bottle'
        else
            "#{number} bottles"
        end
    end

    def bottles(number)
        if (number == -1) then
            '99 bottles'
        elsif (number == 0) then
            'no more bottles'
        elsif (number == 1) then
            '1 bottle'
        else
            "#{number} bottles"
        end
    end

    def take_bottle(number)
        if (number == 0) then
            'Go to the store and buy some more'
        elsif (number == 1) then
            'Take it down and pass it around'
        else
            'Take one down and pass it around'
        end
    end
end