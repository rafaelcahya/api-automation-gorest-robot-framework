from faker import Faker

fake = Faker()

class FakerLibrary:

	def generate_female_first_name(self):
		return fake.first_name_female()
	
	def generate_email(self):
		return fake.email()

	def generate_sentence(self, nb_words=6):
		return fake.sentence(nb_words=int(nb_words))
	