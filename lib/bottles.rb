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
        VerseFactory.create(number).to_s
    end
end

class VerseFactory
    def self.create_first()
        ManyBottlesVerse.new(Bottles.total)
    end

    def self.create(number)
        case number
        when 0
            ZeroBottleVerse.new
        when 1
            OneBottleVerse.new
        when 6
            OneSixPackVerse.new
        else
            ManyBottlesVerse.new(number)
        end
    end
end

class Verse
    attr_reader :quantity
    attr_reader :container

    def to_s()
        "#{self.quantity_in_container().capitalize} of beer on the wall, #{self.quantity_in_container()} of beer.\n" \
        "#{self.action()}, #{self.next().quantity_in_container()} of beer on the wall.\n"
    end

    def quantity_in_container()
        "#{self.quantity} #{self.container}"
    end
end

class ZeroBottleVerse  < Verse
    def initialize()
        @quantity = 'no more'
        @container = 'bottles'
    end

    def action()
        'Go to the store and buy some more'
    end

    def next()
        VerseFactory.create_first()
    end
end

class PassAroundVerse < Verse
    def action()
        "Take #{@pronoun} down and pass it around"
    end

    def next()
        VerseFactory.create(@number_of_bottles - 1)
    end
end

class ManyBottlesVerse < PassAroundVerse
    def initialize(number_of_bottles)
        @number_of_bottles = number_of_bottles
        @quantity = @number_of_bottles
        @container = 'bottles'
        @pronoun = 'one'
    end
end

class OneBottleVerse < PassAroundVerse
    def initialize()
        @number_of_bottles = 1
        @quantity = 1
        @container = 'bottle'
        @pronoun = 'it'
    end
end

class OneSixPackVerse < PassAroundVerse
    def initialize()
        @number_of_bottles = 6
        @quantity = 1
        @container = 'six-pack'
        @pronoun = 'one'
    end
end