<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Group extends Model
{

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
      'id', 'group',
    ];
    protected $table = "groups";


    public function users()
    {
      return $this->belongsToMany('App\User');
    }
}
