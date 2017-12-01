use strict;
use warnings;

main();

sub main {
    my $card = Card->new;

    $card->stdin_card;

    $card->start_game;
}



package Card;

use strict;
use warnings;

=encoding utf8

=head1 NAME

Card - paizajack用サンプルモジュールです。

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

簡単な使い方

    use Card;

    my $card = Card->new;

    $card->stdin_card;

    $card->start_game;


=head1 EXPORT

このモジュールは、L<paizajack|https://paiza.jp/paizajack/>で使用を想定したサンプルモジュールです。
適当に作りましたので、適当に書き換えてください。
シンプルな作りを目指しました。

=head1 SUBROUTINES/METHODS

=head2 new

みんな大好きnewメソッドです。
インスタンス生成時にお使いください。

メンバ変数として、次を持っています。

=over 4

=item *
カードの数値情報の配列

=item *
賭けチップ数

=back

=cut

sub new {
    my $class = shift;
    my $self = {
        card => [],
        betted_chips => 0,
    };
    return bless $self, $class;
}

=head2 stdin_card

カード情報を標準入力から取得するメソッドです。

=cut

sub stdin_card {
    my $self = shift;

    chomp( my $line = <STDIN> );
    my @card = split " ", $line;

    $self->{card} = \@card;
}

=head2 start_game

ゲームを開始します。
ゲーム開始と言いつつ、最初にゲームを開始したかどうかを確認しています。

=cut

sub start_game {
    my $self = shift;

    if( $self->is_first_dealing ) {
        $self->print_betted_chips;

    } else {
        if( $self->is_continuing_game ) {
            $self->print_draw_card;
        } else {
            $self->print_stand;
        }
    }
}

sub is_first_dealing {
    my $self = shift;
    my $is_first = 0;

    $is_first = 1 if $self->{card}->[0] == 0;

    return $is_first;
}

sub is_continuing_game {
    my $self = shift;
    my $is_continuing = 0;

    $is_continuing = 1 if $self->sum < 10; # 閾値

    return $is_continuing;
}

sub sum {
    my $self = shift;
    my $sum_card_number = 0;

    foreach ( @{ $self->{card} } ) {
        $sum_card_number += $_;
    }

    return $sum_card_number;
}

sub print_betted_chips {
    my $self = shift;
    print $self->{betted_chips}; # 賭けチップ数
}

sub print_draw_card {
    my $self = shift;
    print "HIT"; # カードを引く
}

sub print_stand {
    my $self = shift;
    print "STAND"; # 勝負する
    $self->{is_stopped_game} = 1;
    $self->{is_gaming} = 0;
}

=head1 AUTHOR

Morichan

=head1 COPYRIGHT & LICENSE

Copyright (c) 2017 Morichan

This software is released under the MIT License.
https://opensource.org/licenses/mit-license.php

=cut

1;
