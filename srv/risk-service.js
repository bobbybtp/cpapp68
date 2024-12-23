const cds = require('@sap/cds')

module.exports = cds.service.impl(async function() {

    const bupa = await cds.connect.to('API_BUSINESS_PARTNER');

    this.on("READ", 'Suppliers', async req => {
         return bupa.run(req.query);
    });
 
    this.after("READ", 'Risks', risksData => {
       const risks = Array.isArray(risksData) ? risksData : [risksData];
       risks.forEach(risk => {
        if (risks.impact >= 100000 ){
            risk.criticality = 1;
        }
        else {
            risk.criticality = 2;
        }
        
       });

    });


});