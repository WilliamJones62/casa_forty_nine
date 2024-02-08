function pageNav(page) {
    document.getElementById('myCarousel').classList.add("d-none");
    document.getElementById('photosNav').classList.remove("nav-active");
    document.getElementById('bookingNav').classList.remove("nav-active");
    document.getElementById('homeNav').classList.remove("nav-active");
    document.body.style.backgroundImage = "url('assets/medium_pool.jpg')";
    switch (page) {
        case 1:
        document.getElementById("pageText").innerHTML = 'Casa 49 is ideally located 4 blocks from the emblematic Paseo de Montejo, 1 block behind the ever popular "Restaurant Row" on Calle 47, and a block and a half from the wonderful Parque la Plancha. At over 2300 square feet, this modern, open-concept home has 3 bedrooms, and 2 large bathrooms. A stunning 20 foot skylight in the front room provides plenty of light and allows you to stargaze at night. Brazilian Granite, a huge kitchen island, and high-end appliances create a dream Chef’s kitchen. The gorgeous backyard, complete with filtered pool and lush gardens provide your own private Oasis to enjoy the lovely Merida weather. 4 outdoor terraces give you ample opportunity to truly have an outdoor living experience in various areas of this home.';
        document.getElementById('homeNav').classList.add("nav-active");
        break;
        case 2:
        document.getElementById("pageText").innerHTML = '';
        document.getElementById('photosNav').classList.add("nav-active");
        document.body.style.backgroundImage = "url('')";
        document.getElementById('myCarousel').classList.remove("d-none");
        break;
        case 3:
        document.getElementById("pageText").innerHTML = 'To check availability and to make a booking contact Erich Briehl Whatsapp +52 999 960 4450';
        document.getElementById('bookingNav').classList.add("nav-active");
    }
}
