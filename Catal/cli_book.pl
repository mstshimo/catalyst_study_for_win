use strict;
use warnings;
use Encode;

BEGIN{
	unshift @INC, 'C:\data\Catal\lib';
}

use Catal::Api::Book;


my $book = Catal::Api::Book->new();
my $ result = $book->getInfosByPublish('インプレス');

foreach my $item (@$result){
	my $t = $item->title;
	
	Encode::from_to($t, 'utf8', 'shiftsjis');
	my @line = ($item->isbn, $t, $item->price);
	
	print join('|', @line) . "\n";

}

print "hoge";