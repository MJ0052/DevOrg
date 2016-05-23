trigger DuplicateCheck on Lead (before insert) {
    for(Lead leadObj:trigger.new){
        if(LeadDataManipulation.DuplicateCheckOnEmail(leadObj.Email)){
            leadObj.AddError('Email is duplicate');
        }
        if(LeadDataManipulation.DuplicateCheckOnPhone(leadObj.Phone)){
            leadObj.AddError('Phone is duplicate');
        }
    }
}

//check for update
// check whteher the field is changed or not
//