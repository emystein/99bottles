class Bottles
    @@total = 99

    def self.total
        @@total
    end

    def song
        self.verses(@@total, 0)
    end

    def verses(high, low)
        high.downto(low).map { |bottle| self.verse(bottle) }.join("\n")
    end

    def verse(number)
        Verse.number(number).to_s
    end
end

class Verse
    def self.number(number)
        number == 0 ? ZeroBottleVerse.new : ManyBottlesVerse.new(number)
    end

    def to_s()
        "#{self.number_of_bottles().capitalize} of beer on the wall, #{self.number_of_bottles()} of beer.\n" \
        "#{self.take_bottle()}, #{self.next().number_of_bottles()} of beer on the wall.\n"
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
        Verse.number(Bottles.total)
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
        Verse.number(@number - 1)
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