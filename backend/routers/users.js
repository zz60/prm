var express = require('express');
var router = express.Router();
var dbModel = require('../lib/database');

router.get('/:user_id', function(req, res) {
	dbModel.getUser(req.params.user_id, function(err, result) {
		res.end(JSON.stringify(result));
	});
});

router.get('/:user_id/contacts', function(req, res) {
	dbModel.getContacts(req.params.user_id, function(err, result) {
		res.end(JSON.stringify(result));
	});
})

router.get('/:user_id/contacts/:contact_id/entries', function(req, res) {
	dbModel.getEntries(req.params.contact_id, function(err, result) {
		res.end(JSON.stringify(result));
	});
});

router.get('/:user_id/contacts/:contact_id/entries/:entry_id', function(req, res) {
	res.end(req.params);
})

router.post('/:user_id/contacts', function(req, res) {
	dbModel.postContact(req.params.user_id, req.query.firstName, req.query.lastName, req.query.phoneNumber, req.query.email, req.query.location, req.query.company, req.query.position, function(err, result) {
		res.send(JSON.stringify(err));
		res.end(JSON.stringify(result));
	});
}); 

module.exports = router;