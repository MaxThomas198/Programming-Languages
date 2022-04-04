use v6;
use lib '.';
use RemoveSpaces;
use Tokenize;
use PrettyPrint;

# Read the test program
my $data = slurp "program.txt";

say "The original program is";
say "--------------";
say $data;
say "--------------";

# Remove spaces
my $removed = removeSpaces($data);

say "After removing spaces program is";
say "--------------";
say $removed;
say "--------------";

# Tokenize
my @tokens = getTokens($removed);

say "Tokens are";
say "--------------";
for @tokens -> $token {
  say $token;
}
say "--------------";

# Pretty print
my $pretty = prettyPrint(@tokens);

say "Pretty print program is";
say "--------------";
say $pretty;
say "--------------";