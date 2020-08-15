const mongoose = require('mongoose');
const DispatchSchema = mongoose.Schema({

    dispatchRecord: {
      type: Number,
      required: true
    },
    dispatchAmount: {
      type: Number,
      required: true
    },
    dispatchType: {
      type: String,
      required: true
    },
    dispatchTime: {
      type: String,
      required: true
    },
    dispatchConfirmation: {
      type: String,
      required: true
    },
    truckNumber: {
      type: String,
      required: false
    },
    contactPerson: {
      type: String,
      required: false
    },
    contactNumber: {
      type: Number,
      required: false
    },
    alternativeContactNumber: {
      type: Number,
      required: false
    },
    docketNumber: {
      type: String,
      required: false
    },
    recipientPerson: {
      type: String,
      required: false
    },
    recipientContactNumber: {
      type: Number,
      required: false
    },
    containerNumber: {
      type: String,
      required: false
    },
    customsClearingPoint: {
      type: String,
      required: false
    },
    description: {
      type: String,
      required: false
    },
    roles: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Role"
      }
    ]
});
//invoice number and OC number that the dispatch executive will already have, will have either
//change drop down to invoice number, order confirmation number, packing list

const Dispatch = mongoose.model('Dispatch', DispatchSchema);
module.exports = Dispatch;


  
