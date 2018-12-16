#!perl

use strict;
use warnings;
use Test::Exception;
use Test::More 0.98;

use Date::TimeOfDay;

subtest "new, hour, minute, second, nanosecond, hms, float, stringify" => sub {
    my $tod;

    dies_ok  { Date::TimeOfDay->new() } 'missing required param -> dies';
    lives_ok { $tod = Date::TimeOfDay->new(hour=>23, minute=>59, second=>59, nanosecond=>999_999_000) };
    dies_ok  { $tod = Date::TimeOfDay->new(hour=>24, minute=>59, second=>59, nanosecond=>999_999_000) } 'invalid hour -> dies';
    dies_ok  { Date::TimeOfDay->new(hour=>23, minute=>59, second=>59, nanosecond=>999_999_000, year=>1) } 'unknown param -> dies';

    is($tod->hour, 23);
    is($tod->minute, 59);
    is($tod->second, 59);
    is($tod->nanosecond, 999_999_000);

    is($tod->float, 86399.999999);

    is($tod->stringify, "23:59:59");

    is($tod->hms, "23:59:59");
};

subtest from_hms => sub {
    dies_ok  { Date::TimeOfDay->from_() } 'missing required param -> dies';
    dies_ok  { Date::TimeOfDay->from_(hms=>"") } 'invalid hms -> dies 1';
    dies_ok  { Date::TimeOfDay->from_(hms=>"24:00:00") } 'invalid hms -> dies 2';
    dies_ok  { Date::TimeOfDay->from_(hms=>"00:00:00", foo=>2) } 'unknown param -> dies';
    is(Date::TimeOfDay->from_hms(hms=>"23:59:59")->hms, "23:59:59");

    my $tod = Date::TimeOfDay->from_hms(hms=>"23:59:59.025");
    is($tod->hms, "23:59:59");
    is($tod->nanosecond, 25_000_000);
};

subtest from_float => sub {
    dies_ok  { Date::TimeOfDay->from_float() } 'missing required param -> dies';
    dies_ok  { Date::TimeOfDay->from_float(float=>-1) } 'invalid float -> dies 1';
    dies_ok  { Date::TimeOfDay->from_float(float=>86400) } 'invalid float -> dies 2';
    dies_ok  { Date::TimeOfDay->from_float(float=>1, foo=>2) } 'unknown param -> dies';
    is(Date::TimeOfDay->from_float(float=>86399)->hms, "23:59:59");
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
