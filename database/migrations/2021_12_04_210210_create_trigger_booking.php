<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class CreateTriggerBooking extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
      DB::unprepared("CREATE TRIGGER `restore_booking` BEFORE DELETE ON `bookings`
      FOR EACH ROW BEGIN
          SET @oldP = (SELECT passenger FROM detail_bookings WHERE booking_id = OLD.id);
          SET @oldC = (SELECT class FROM detail_bookings WHERE booking_id = OLD.id);
          IF old.vehicle = 'plane' THEN
            IF @oldC = 'eco_seat' THEN
              UPDATE plane_schedules SET eco_seat = eco_seat + @oldP WHERE id = OLD.schedule_id;
            ELSEIF @oldC = 'bus_seat' THEN
              UPDATE plane_schedules SET bus_seat = bus_seat + @oldP WHERE id = OLD.schedule_id;
            ELSEIF @oldC = 'first_seat' THEN
              UPDATE plane_schedules SET first_seat = first_seat + @oldP WHERE id = OLD.schedule_id;
            END IF;
          END IF;
        END");
    }

    
/**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
      DB::unprepared("DROP TRIGGER `restore_booking` ");
    }
}
