<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Group_user extends Model
{

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $guarded = [
      'id'
    ];
    protected $table = "group_user";

}