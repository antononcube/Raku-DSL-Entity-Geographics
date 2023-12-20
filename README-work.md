# DSL::Entity::Geographics

Raku grammar classes for geographic entities (names.)

## Installation

From [Zef ecosystem](https://raku.land):

```
zef install DSL::Entity::Geographics
```

From GitHub:

```
zef install https://github.com/antononcube/Raku-DSL-Entity-Geographics.git
```

## Examples

### Basic entity name retrieval

Here we show how the entity ID is retrieved using an adjective:

```perl6
use DSL::Entity::Geographics;

ToGeographicEntityCode('Brazilian');
```

### Grammar parsing

One of the main motivations for this package is to be able to use known country names and related adjectives
as grammar tokens. For example, in packages like ["DSL::English::FoodPreparationWorkflows"](https://github.com/antononcube/Raku-DSL-English-FoodPreparationWorkflows), [AAp4].

Here are few grammar parsing examples:

```perl6
use DSL::Entity::Geographics::Grammar;

my $pCOMMAND = DSL::Entity::Geographics::Grammar.new;

$pCOMMAND.set-resources(DSL::Entity::Geographics::resource-access-object());

say $pCOMMAND.parse('Argentina', rule => 'geographic-entity-command');
```

```perl6
say $pCOMMAND.parse('United States of America', rule => 'geographic-entity-command');
```

## References

[AAp1] Anton Antonov,
[DSL::Shared Raku package](https://github.com/antononcube/Raku-DSL-Shared),
(2020),
[GitHub/antononcube](https://github.com/antononcube).

[AAp2] Anton Antonov,
[DSL::Entity::Jobs Raku package](https://github.com/antononcube/Raku-DSL-Entity-Jobs),
(2021),
[GitHub/antononcube](https://github.com/antononcube).

[AAp3] Anton Antonov,
[DSL::Entity::Foods Raku package](https://github.com/antononcube/Raku-DSL-Entity-Foods),
(2021),
[GitHub/antononcube](https://github.com/antononcube).

[AAp4] Anton Antonov,
[DSL::English::FoodPreparationWorkflows Raku package](https://github.com/antononcube/Raku-DSL-English-FoodPreparationWorkflows),
(2021),
[GitHub/antononcube](https://github.com/antononcube).
