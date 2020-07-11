class Bottles
    @@total = 99

    def self.total
        @@total
    end

    def song
        self.verses(@@total, 0)
    end

    def verses(high, low)
        high.downto(low).map { |number| self.verse(number) }.join("\n")
    end

    def verse(number)
        Verse.create(number).to_s
    end
end

class Verse
    attr_reader :quantity
    attr_reader :container

    def self.create(number)
        case number
        when 0
            ZeroBottleVerse.new(sucessor = ManyBottlesVerse.new(Bottles.total))
        when 1
            OneBottleVerse.new
        when 6
            OneSixPackVerse.new
        else
            ManyBottlesVerse.new(number)
        end
    end

    def to_s()
        "#{quantity.capitalize} #{container} of beer on the wall, #{quantity} #{container} of beer.\n" \
        "#{action()}, #{sucessor().quantity} #{sucessor().container} of beer on the wall.\n"
    end

    def action()
        "Take #{@pronoun} down and pass it around"
    end

    def sucessor()
        Verse.create(@number - 1)
    end
end

class ZeroBottleVerse < Verse
    def initialize(sucessor)
        @quantity = 'no more'
        @container = 'bottles'
        @sucessor = sucessor
    end

    def action()
        'Go to the store and buy some more'
    end

    def sucessor()
        @sucessor
    end
end

class ManyBottlesVerse < Verse
    def initialize(number)
        @number = number
        @quantity = "#{number}"
        @container = 'bottles'
        @pronoun = 'one'
    end
end

class OneBottleVerse < Verse
    def initialize()
        @number = 1
        @quantity = '1'
        @container = 'bottle'
        @pronoun = 'it'
    end
end

class OneSixPackVerse < Verse
    def initialize()
        @number = 6
        @quantity = '1'
        @container = 'six-pack'
        @pronoun = 'one'
    end
end