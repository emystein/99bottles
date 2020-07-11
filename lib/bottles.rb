class Bottles
    def self.total
        99
    end

    def song
        self.verses(Bottles.total, 0)
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
            ZeroBottleVerse.new(sucessor = create(Bottles.total))
        when 1
            AnyBottlesVerse.new(number, quantity = '1', container = 'bottle', pronoun = 'it')
        when 6
            AnyBottlesVerse.new(number, quantity = '1', container = 'six-pack', pronoun = 'one')
        else
            AnyBottlesVerse.new(number, quantity = number.to_s, container = 'bottles', pronoun = 'one')
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

class AnyBottlesVerse < Verse
    def initialize(number, quantity, container, pronoun)
        @number = number
        @quantity = quantity
        @container = container
        @pronoun = pronoun
    end
end