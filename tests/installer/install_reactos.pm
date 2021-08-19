use strict;
use warnings;
use testapi;

sub run() {
    # select en_US as the installation language
    assert_screen('textmode-installer_language-selection', timeout => 60);
    send_key('ret');

    # display licensing and go back
    assert_screen('textmode-installer_welcome-screen');
    send_key('l');
    assert_screen('textmode-installer_license');
    send_key('ret');

    # confirm that we know that this is a beta
    assert_screen('textmode-installer_welcome-screen');
    send_key('ret');
    assert_screen('textmode-installer_version-status');
    send_key('ret');

    # main setup screen => adjust the resolution to 1024x786x32
    assert_screen('textmode-installer_setup');
    for (my $i=0; $i < 3; $i++){
        send_key('up', wait_screen_change => 1);
    }
    send_key('ret');
    assert_screen('textmode-installer_setup_choose-resolution-default');
    for (my $i=0; $i < 4; $i++){
        send_key('down', wait_screen_change => 1);
    }
    assert_screen('textmode-installer_setup_choose-resolution-final');
    send_key('ret');
    assert_screen('textmode-installer_setup_new-resolution');

    # change the keyboard layout to German
    send_key('down', wait_screen_change => 1);
    send_key('down', wait_screen_change => 1);
    send_key('ret');
    assert_screen('textmode-installer_setup_choose-keyboard-layout_en-US');
    for (my $i=0; $i < 8; $i++){
        send_key('down', wait_screen_change => 1);
    }
    assert_screen('textmode-installer_setup_choose-keyboard-layout_de-DE');
    send_key('ret');
    assert_screen('textmode-installer_setup_new-keyboard-layout');

    # accept the new settings
    send_key('down');
    assert_screen('textmode-installer_setup_accept-these-settings');
    send_key('ret');

    # partitioner: create a primary partition with the default size
    assert_screen('textmode-installer_partitioner');
    send_key('p');
    assert_screen('textmode-installer_partitioner_set-partition-size');
    send_key('ret');
    assert_screen('textmode-installer_partitioner_new-partition-created');
    # select it for installation
    send_key('ret');
    # quick format with FAT
    assert_screen('textmode-installer_partitioner_choose-filesystem');
    send_key('ret');
    assert_screen('textmode-installer_partitioner_confirm-format');
    send_key('ret');

    # confirm the default directory where ReactOS should be installed
    assert_screen('textmode-installer_installation-directory');
    send_key('ret');

    # installation starts and finishes *very* quickly => don't try to match it
    # wait for the bootloader location selection screen to show up => use the default
    assert_screen('textmode-installer_bootloader-location');
    send_key('ret');
    assert_screen('textmode-installer_reboot-prompt');
    send_key('ret');

    # the system reboots now
    assert_screen('textmode-installer_bootloader');
}

sub test_flags {
    return {milestone => 1};
}

1;
