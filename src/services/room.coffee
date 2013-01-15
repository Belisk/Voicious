###

Copyright (c) 2011-2012  Voicious

This program is free software: you can redistribute it and/or modify it under the terms of the
GNU Affero General Public License as published by the Free Software Foundation, either version
3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this
program. If not, see <http://www.gnu.org/licenses/>.

###

Request     = require 'request'
Config      = require '../common/config'
{Session}   = require './session'
{Errors}    = require '../core/errors'

class _Room
        constructor : () ->

        roomPage : (req, res) =>
            user    = req.currentUser
            options =
                    title   : 'Voicious'
                    login   : user.name
                    room    : req.params.roomid
            res.render 'room', options

        newRoom : (req, res, param) =>
            Request.post {
                json    : param
                url     : "#{Config.RestAPI.Url}/room"
            }, (e, r, body) =>
                if e? or r.statusCode > 200
                    throw new Errors.Error
                else
                    res.redirect "/room/#{body.id}"

exports.Room    = new _Room
exports.Routes  =
    get :
        '/room/:roomid' : (Session.ifUser.curry exports.Room.roomPage)
