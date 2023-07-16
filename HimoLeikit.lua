require("weneFunc")
nimet={}
hahmot={}
peli={alota=false,voitto=false,kuollut={"Ei oo ees alkanu viel"},kuollutN=0,pv=0,hetket=0,entinen="",ansat={}}
sana={
alotapk={"hautausmaalta","kellarista","kaapista","vessasta","Ylilaudalta","Rukouskerholta","poliisivankilasta"}, --Aloituspaikat
alotavb={"karkaavat","kiemurtelevat","juoksevat","kaatuvat","nautiskelivat","keulivat"}, --AloitusVerbit
ansaKuoli={"kuolla kupsahti","nukkui pois","menehtyi","posahti","todisti rokotteen toimivan","sai kiveskiertyman"}, 
ansaHaava={"sai tulehduksen","vuotaa verta","mursi luun","sai sisaisen verenvuodon","sattu :c","kaatu"}, 
tappKuoli={"sai turpaan","kuoli tappelun myota","kivekset murtui","todisti rokotteen toimivan","lepaa","lahti Georgen keikalle","sai lobotomian","tunki siilin peppuun"},
tappHaava={"sai haavan","lyotiin astetta kovempaa","otti puukosta","kivekset potkaistiin","pistettiin shokkiin"},
pass={"poimii kukkia","polttaa kukkaa","afkaa","taistelee konetonttuja vastaan","gonahtaa","etsii akuutti nippii","hiisaa","omena","appelsiini","televisio","raapii kassejaan","selaa ylilautaa","vierailee eskarilla","lurkkaa","ostaa kookoksen","jattaa Taren mankin","harrastaa suomalaista kissailua","trippaa","nisteilee","tanssii konetonttujen kanssa","kaivaa peppua","funtsii","panee puuta","ajattelee punaista ankkaa","muuttaa muotoa","on autisti...","vihaa kaikkia"},
auta={"paransi","pussasi","pani","antoi kultainen suihku","antaa akuuttii nippii","tyhjensi pallit","pelasti selibaatista"},
autaItse={"omasi stoalaisen mielialan","paransi itsensa","veti ketarikannit","poisti Leaguen","meni toihin","sai kelatuet"},
ansa={"asetti ansan","asensi ansan trollauksena","kaivoi ansakuopan","pisti huumepiikkeja maahan","paskansi maahan","ripuloi"},
ansaOsu={"osui ansaan","tepsahteli ansaan","astui harhaan (ansaan)"},
piilo={"meni piiloon","piiloutui","meni puskaan","nossoilee","puskacamppaa","joutui vankilaan","meni paskalle","meni etsimaan Yanden ruumista","karkaa armeijasta"},
tappelu={"VS","tappelee","aikoi hakata","uhkailee","vittuilee","runkutteli","lahjoittaa pari nukuttavaa","yritti cancellaa","heitti kookoksen"}
}
logs={}
teksti=""

math.randomseed(os.time())


--Hanki kaikkien hahmojen nimet
function Nimet()
	--[[for nimi in io.lines("HimoHahmot.wene") do
		nimet[#nimi] = nimi
	end--]]
	x=1
	bleeh=io.open("HimoHahmot.wene");mehmet=bleeh:lines()
	for miau in kives do
		nimet[x]=miau
		x=x+1
	end
	bleeh:close()
end

--Tee pöytä hahmoista
function Hahmot()
	hahmot={}
	for i,v in pairs(nimet)do
		a={}
		a={nimi=v,p=false,hv=false,t=0,ePv=2} --nimi, piiloutunut, haavoittunut, tapot, elinpäivät (laskee per pv kun haavoittunut)
		table.insert(hahmot,a)
	end
end

--[[Testaa toimiiko paska koodisi
for i,v in pairs(hahmot)do
	print(v.nimi)
end--]]

function Intro()
	Clear()
	logs={}
	peli={alota=false,kuollut={"Ei oo ees alkanu viel"},kuollutN=0,pv=0,hetket=0,entinen="",ansat={}}
	print("    HimoLeikit")
	Sleep(1)
	print("        :D")
	Sleep(1)
	Clear()
	Nimenhuuto()
	Kmt()
end

function Nimenhuuto()
	Nimet()
	Hahmot()
	print("#----------------#\n    NIMENHUUTO\n#----------------#\n")
	n=0
	for i,v in pairs(nimet)do
		io.write(v, " | ")
		n=n+1
		if n==5 then
			io.write("\n")
			n=0
		end
	end
	print("\n\n[" .. TableLen(hahmot) .. "]")
	io.write("\n")
end

function Kmt()
	n=false
	io.write("\n-------------------\n" .. "[K:" .. peli.kuollutN .. "]\n> ")
	x=io.read():lower()
	if x=="aloita" and not peli.alota then
		peli.alota=true
		Peli()
	end
	if x=="kuolleet" then
		Kuollut()
		io.read()
		n=true
	end
	if x=="loppu" then
		Clear()
		os.exit()
	end
	if x=="re:nh" then
		print("\n\n")
		Nimenhuuto()
	end
	if x=="re" then
		Intro()
	end
	if not peli.alota then
		Kmt()
	end
	return n
end

function Kuollut()
	Clear()
	print("Kuolleita: " .. peli.kuollutN)
	n=0
	for i,v in pairs(peli.kuollut)do
		io.write(v, " | ")
		n=n+1
		if n==5 then
			io.write("\n")
			n=0
		end
	end
	io.write("\n")
end

function Peli()
	if peli.pv==0 then
		Clear()
		peli.kuollut={}
		teksti="HimoLeikit alkavat, kun leikkijat " .. sana.alotavb[math.random(1, TableLen(sana.alotavb))] .. " " .. sana.alotapk[math.random(1,TableLen(sana.alotapk))] .. " ulos."
		Sleep(1)
		LPrint(teksti)
		peli.pv=peli.pv+1
	end
	PeliLoop()
end

function PeliLoop()
	hetketN=0
	while peli.hetket<30 do --Kuinka monta hetkeä (tapahtumaa), päivässä tapahtuu
		--print(TableLen(hahmot))
		if hetketN==5 then --Tapahtumat pysähtyy viiden väleihin, jotta kerkeää lukemaan mitä tapahtuu
			Kmt() --Komento
			Clear() --Pyyhi konsoli
			Logit() --Näytä paska mitä tapahtunut
			hetketN=0
		end
		PeliEvent()
		if TableLen(hahmot)==1 then
			peli.voitto=true
			break
		end
		Sleep(1)
		peli.hetket=peli.hetket+1
		hetketN=hetketN+1
	end
	if not peli.voitto then
		Sleep(1)
		UusiPV()
	else
		Voittaja()
	end
end

function Voittaja()
	Sleep(3)
	Clear()
	print("  HimoLeikkien voittaja on.")
	Sleep(1)
	Clear()
	print("  HimoLeikkien voittaja on..")
	Sleep(1)
	Clear()
	print("  HimoLeikkien voittaja on...")
	Sleep(1)
	Clear()
	LPrint("\n\n  HimoLeikkien voittaja on " .. hahmot[1].nimi:upper() .. "!\n\n[Paiva: " .. peli.pv .. "]")
	VoittajaTiedosto()
	Sleep(5)
	os.exit()
end

function VoittajaTiedosto()
	nimi=""
	aika=os.date("*t")
	nimi=hahmot[1].nimi .. "_" .. aika.day .. "D_" .. aika.hour .. "H_" .. aika.min .. "S.txt"
	tiedosto=io.open("./_HIMOLEIKIT/" .. nimi, "w")
	--[[
	tiedosto:write("A")				testi kuinka LUA kirjoittaa tiedostoon
	tiedosto:write("B")				LUA kirjoitti tiedostoon muodossa "ABC", yhtenä pätkänä
	tiedosto:write("C")--]]
	for i,v in pairs(logs) do
		tiedosto:write(v .. "\n")
	end
end

function UusiPV()
	peli.pv=peli.pv+1
	peli.hetket=0
	LPrint("\n\n\n Uusi paiva koittaa...\n [Paiva: " .. peli.pv .. "]\n")
	for i,v in pairs(hahmot) do
		if v.hv then
			v.ePv=v.ePv-1
			if v.ePv==0 then
				LPrint(" [" .. v.nimi .. " ei parantunut ajoissa ja kuoli]")
				Sleep(1)
				Hetki.Kuoli(i)
				if TableLen(hahmot)==1 then
					peli.voitto=true
					Voittaja()
				end
			end
		end
		v.p=false
	end
	Kmt()
	Clear()
	Logit()
	Peli()
end

function LPrint(x)
	print(" " .. x .. "\n")
	--logs=logs .. x .. "\n"
	table.insert(logs," " .. x)
end

function Logit()
	--print(logs .. "-------------------------\n\n")
	if TableLen(logs)<=5 then
		for i,v in pairs(logs) do
			print(v)
		end
	else
		for i=5,0,-1 do
			print(logs[TableLen(logs)-i])
		end
	end
	print("-------------------------\n\n")
end
XD=0
function PeliEvent()
	teksti="reroll"
	--[[if XD<2 then --Testi, että toimiiko kuolema
		Hetki.Kuoli(1)
		XD=XD+1
	end--]]
	while teksti=="reroll" do
		teksti=Hetki.Roll(math.random(1,60))
	end
	LPrint(teksti)
end

Hetki={}

function Hetki.Roll(n) --Tappelu(1-15), auttaminen(16-21), ansa(22-30), piiloutuminen(31-34), passiivinen(35-)
	Tapahtu=""
	tapahtu=0
	
	--[[
	Syy tämän funktion kirjoittamiseen näin on:
	1. Saa helpommin muokattua tapahtumien mahdollisuuksia
	2. Saa helpommin lisättyä tapahtumia
	Joten turvat tukkoon
	--]]
	
	if n>15 then tapahtu=1 end	--AUTA
	if n>21 then tapahtu=2 end	--ANSA
	if n>30 then tapahtu=3 end	--PIILO
	if n>34 then tapahtu=4 end	--PASSIIVI
	
	r=math.random(1,TableLen(hahmot))
	while hahmot[r].nimi==peli.entinen do
		r=math.random(1,TableLen(hahmot))
	end
	h=hahmot[r].nimi
	peli.entinen=h
	
	if tapahtu==0 then	--TAPPELU
		Tapahtu=Hetki.Tappelu(h,r) 
	end
	if tapahtu==1 then	--AUTA
		Tapahtu=Hetki.Auta(h,r)
	end
	if tapahtu==2 then	--ANSA
		Tapahtu=Hetki.Ansa(h,r)
	end
	if tapahtu==3 then	--PIILO
		Tapahtu=Hetki.Piilo(h,r)
	end
	if tapahtu==4 then	--PASSIIVI
		Tapahtu=Hetki.Passiivi(h,r)
	end
	return Tapahtu
end

--"Vittu Saatana"-alue alkaa

function Hetki.Tappelu(hahmo,id)
	retu="reroll"
	x=math.random(1,TableLen(hahmot))
	y=false
	for i=5+TableLen(hahmot),0,-1 do
		if hahmo~=hahmot[x].nimi and not hahmot[x].p then
			y=true
			break
		end
		x=math.random(1,TableLen(hahmot))
	end
	if y then
		n=math.random(0,10)
		if n<=5 then
			retu=hahmo .. " " .. sana.tappelu[math.random(1,TableLen(sana.tappelu))] .. " " .. hahmot[x].nimi .. "\n     [" .. hahmo .. " " .. Haavoittua(id,"tappelu")
		else
			retu=hahmo .. " " .. sana.tappelu[math.random(1,TableLen(sana.tappelu))] .. " " .. hahmot[x].nimi .. "\n     [" .. hahmot[x].nimi .. " " .. Haavoittua(x,"tappelu")
		end
	end
	return retu
end

function Hetki.Auta(hahmo,id)
	retu="reroll"
	x=math.random(1,TableLen(hahmot))
	y=false
	for i=5+TableLen(hahmot),0,-1 do
		if hahmot[x].hv and not hahmot[x].p then
			y=true
			break
		end
		x=math.random(1,TableLen(hahmot))
	end
	if y then
		hahmot[x].hv=false
		if hahmo==hahmot[x].nimi then
			retu=hahmo .. " " .. sana.autaItse[math.random(1,TableLen(sana.autaItse))] .. " (P+)"
		else
			retu=hahmo .. " " .. sana.auta[math.random(1,TableLen(sana.auta))] .. " " .. hahmot[x].nimi .. " (P+)"
		end
	end
	return retu
end

function Hetki.Ansa(hahmo,id)
	n=math.random(0,100)
	retu="reroll"
	x=false							--On jo laittanut ansan
	if n<=25 then					--Asettaa ansaa
		for i,v in pairs(peli.ansat) do
			if v.nimi==hahmo then	--Tarkista onko pelaajalla jo asennettu ansa
				x=true
				break
			end
		end
		if not x then				--Lopettaa loopin, jos pelaaja on jo asentanut ansan ja re-rollaa, muuten asentaa ansan
			retu=hahmo .. " " .. sana.ansa[math.random(1,TableLen(sana.ansa))] .. " (A+)"
			table.insert(peli.ansat,hahmo)
		else
			retu="reroll"
		end
	else							--Osuu ansaan
		if peli.ansat[1]~=nil then
			if hahmo==peli.ansat[1] then
				retu=hahmo .. " " ..sana.ansaOsu[math.random(1,TableLen(sana.ansaOsu))] .. ", jonka itse asensi\n     [" .. hahmo .. " " .. Haavoittua(id,"ansa")
			else
				retu=hahmo .. " " ..sana.ansaOsu[math.random(1,TableLen(sana.ansaOsu))] .. ", jonka " .. peli.ansat[1] .. " asensi\n     [" .. hahmo .. " " .. Haavoittua(id,"ansa")
			end
			table.remove(peli.ansat,1)
		end
	end
	--[[if retu=="[An]" then					Tää toimii hyvänä muistutuksena vammaisesta ajattelusta
		homo=""
		if x then
			homo="true"
		else homo="false" end
		retu=retu .. "[n: " .. n .. "]    [x: " .. homo .. "]    [hahmo: " .. hahmo .. "]"
	end--]]
	return retu
end

function Hetki.Piilo(hahmo,id)
	retu="reroll"
	if not hahmot[id].p then
		hahmot[id].p=true
		retu=hahmo .. " " .. sana.piilo[math.random(1,TableLen(sana.piilo))] .. " (P)"
	end
	return retu
end

function Hetki.Passiivi(hahmo,id)
	return hahmo .. " " .. sana.pass[math.random(1,TableLen(sana.pass))]
end

function Haavoittua(id,tyyppi)
	tyyppi=tyyppi:lower()
	n=math.random(1,100)
	retu=""
	kuoli=false
	if n<11 then
		kuoli=true
	else
		if hahmot[id].hv then
			hahmot[id].ePv=hahmot[id].ePv-1
			if hahmot[id].ePv<=0 then
				kuoli=true
			end
		else
			hahmot[id].hv=true
		end
		if tyyppi=="ansa" then
			retu=sana.ansaHaava[math.random(1,TableLen(sana.ansaHaava))] .. "] (H)"
		end
		if tyyppi=="tappelu" then
			retu=sana.tappHaava[math.random(1,TableLen(sana.tappHaava))] .. "] (H)"
		end
	end
	if kuoli then
		Hetki.Kuoli(id)
		if tyyppi=="ansa" then
			retu=sana.ansaKuoli[math.random(1,TableLen(sana.ansaKuoli))] .. "] (K)"
		end
		if tyyppi=="tappelu" then
			retu=sana.tappKuoli[math.random(1,TableLen(sana.tappKuoli))] .. "] (K)"
		end
	end
	return retu
end

--"Vittu Saatana"-alue loppuu

function Hetki.Kuoli(n)
	peli.kuollutN=peli.kuollutN+1
	peli.kuollut[TableLen(peli.kuollut)+1]=hahmot[n].nimi
	table.remove(hahmot,n)
end

Intro()