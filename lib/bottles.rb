class Verse
    def to_s()
        "#{self.bottles().capitalize} of beer on the wall, #{self.bottles()} of beer.\n" \
        "#{self.take_bottle()}, #{self.next().bottles()} of beer on the wall.\n"
    end
end

class ManyBottlesVerse < Verse
    def initialize(number)
        @number = number
    end

    def bottles()
        "#{@number} bottles"
    end

    def take_bottle()
        'Take one down and pass it around'
    end

    def next()
        if (@number > 2) then
            ManyBottlesVerse.new(@number - 1)
        else
            OneBottleVerse.new()
        end
    end
end

class OneBottleVerse < Verse
    def bottles()
        '1 bottle'
    end

    def take_bottle()
        'Take it down and pass it around'
    end

    def next()
        ZeroBottlesVerse.new()
    end
end

class ZeroBottlesVerse  < Verse
    def bottles()
        'no more bottles'
    end

    def take_bottle()
        'Go to the store and buy some more'
    end

    def next()
        ManyBottlesVerse.new(99)
    end
end

class Bottles
    def song()
        self.verses(99, 0)
    end

    def verses(high, low)
        verses = ''

        (low..high).reverse_each do |bottle|
            verses << "#{self.verse(bottle)}"
            verses << "\n" unless bottle == low
        end
        
        verses
    end

    def verse(number)
        case number
            when 0
                ZeroBottlesVerse.new.to_s
            when 1
                OneBottleVerse.new.to_s
            else
                ManyBottlesVerse.new(number).to_s
        end
    end
end
