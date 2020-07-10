class Verse
    def self.number(number)
        case number
            when 0
                ZeroBottleVerse.new
            else
                ManyBottlesVerse.new(number)
        end
    end

    def to_s()
        "#{self.number_of_bottles().capitalize} of beer on the wall, #{self.number_of_bottles()} of beer.\n" \
        "#{self.take_bottle()}, #{self.next().number_of_bottles()} of beer on the wall.\n"
    end
end

class SingularCardinality
    def suffix()
        ''
    end

    def one()
        'it'
    end
end

class PluralCardinality
    def suffix()
        's'
    end

    def one()
        'one'
    end
end

class ManyBottlesVerse < Verse
    def initialize(number)
        @number = number
        @cardinality = number == 1 ? SingularCardinality.new : PluralCardinality.new
    end

    def number_of_bottles()
        "#{@number} bottle#{@cardinality.suffix}"
    end

    def take_bottle()
        "Take #{@cardinality.one} down and pass it around"
    end

    def next()
        if (@number > 1) then
            ManyBottlesVerse.new(@number - 1)
        else
            ZeroBottleVerse.new()
        end
    end
end

class ZeroBottleVerse  < Verse
    def number_of_bottles()
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
        high.downto(low).map { |bottle| verse(bottle).to_s }.join("\n")
    end

    def verse(number)
        Verse.number(number).to_s
    end
end
