#!perl

use strict;
use warnings;
use Test::Exception;
use Test::More 0.98;

use Date::TimeOfDay;

subtest "new, hour, minute, second, nanosecond, hms, stringify" => sub {
    my $tod;

    dies_ok  { Date::TimeOfDay->new() } 'missing required param -> dies';
    lives_ok { $tod = Date::TimeOfDay->new(hour=>23, minute=>59, second=>59, nanosecond=>999_999_999) };
    dies_ok  { $tod = Date::TimeOfDay->new(hour=>24, minute=>59, second=>59, nanosecond=>999_999_999) } 'invalid hour -> dies';
    dies_ok  { Date::TimeOfDay->new(hour=>23, minute=>59, second=>59, nanosecond=>999_999_999, year=>1) } 'unknown param -> dies';

    is($tod->hour, 23);
    is($tod->minute, 59);
    is($tod->second, 59);
    is($tod->nanosecond, 999_999_999);

    is($tod->stringify, "23:59:59");
    is($tod->hms, "23:59:59");
};

subtest now_local => sub {
    my $tod = Date::TimeOfDay->now_local;
    ok 1;
};

subtest hires_now_local => sub {
    my $tod = Date::TimeOfDay->hires_now_local;
    ok 1;
};

subtest hires_now_utc => sub {
    my $tod = Date::TimeOfDay->now_utc;
    ok 1;
};

subtest hires_now_utc => sub {
    my $tod = Date::TimeOfDay->hires_now_utc;
    ok 1;
};

done_testing;
