<x-app-layout>
    <x-slot name="header">
        <h2 class="header-title flex items-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
            </svg>
            {{ __('Ajouter une nouvelle moto') }}
        </h2>
    </x-slot>

    <div class="content-panel">
        <div class="panel-header">
            <h3 class="panel-title">Informations de la moto</h3>
        </div>
        <div class="panel-body p-4">
            @if ($errors->any())
                <div class="bg-engine-red/10 text-engine-red p-4 rounded-md mb-6 border border-engine-red/30">
                    <div class="font-medium">{{ __('Oups! Quelque chose s\'est mal passé.') }}</div>
                    <ul class="mt-3 list-disc list-inside text-sm">
                        @foreach ($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form action="{{ route('motos.store') }}" method="POST">
                @csrf

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <div class="mb-4">
                            <label for="model_id" class="block text-polished-chrome text-sm font-medium mb-1">Modèle de moto <span class="text-engine-red">*</span></label>
                            <select name="model_id" id="model_id" required class="form-input">
                                <option value="">Sélectionner un modèle</option>
                                @foreach($models as $model)
                                    <option value="{{ $model->id }}" {{ old('model_id') == $model->id ? 'selected' : '' }}>
                                        {{ $model->marque }} ({{ $model->annee }})
                                    </option>
                                @endforeach
                            </select>
                            <p class="text-polished-chrome/70 text-xs mt-1">Sélectionnez le modèle de la moto.</p>
                        </div>

                        <!-- Si vous avez des attributs supplémentaires spécifiques aux motos, ajoutez-les ici -->
                        
                        <div class="mt-6">
                            <p class="text-polished-chrome text-sm">Les champs marqués d'un <span class="text-engine-red">*</span> sont obligatoires.</p>
                        </div>
                    </div>

                    <div class="bg-carbon-fiber p-4 rounded-lg">
                        <h4 class="text-white font-bold mb-4 flex items-center">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                            </svg>
                            Informations sur l'ajout de motos
                        </h4>

                        <ul class="space-y-3 mb-6">
                            <li class="flex items-start">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-exhaust-blue mr-2 flex-shrink-0 mt-0.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                                </svg>
                                <span class="text-polished-chrome text-sm">Vous devez d'abord sélectionner un <strong class="text-white">modèle de moto</strong> existant.</span>
                            </li>
                            <li class="flex items-start">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-exhaust-blue mr-2 flex-shrink-0 mt-0.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                                </svg>
                                <span class="text-polished-chrome text-sm">Si le modèle souhaité n'existe pas encore, vous devez d'abord <strong class="text-white">créer un nouveau modèle</strong> dans la section des modèles.</span>
                            </li>
                            <li class="flex items-start">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-exhaust-blue mr-2 flex-shrink-0 mt-0.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                                </svg>
                                <span class="text-polished-chrome text-sm">Une moto ajoutée pourra ensuite être <strong class="text-white">associée à des pièces détachées</strong> spécifiques.</span>
                            </li>
                        </ul>

                        <div class="bg-deep-metal rounded p-3 border border-gray-700">
                            <h5 class="font-bold text-white mb-2">Avez-vous besoin d'ajouter un nouveau modèle ?</h5>
                            <p class="text-polished-chrome text-sm mb-3">Si le modèle de moto que vous souhaitez ajouter n'existe pas dans la liste, créez d'abord un nouveau modèle.</p>
                            <a href="{{ route('models.create') }}" class="text-exhaust-blue hover:text-white transition-colors flex items-center w-fit">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                                </svg>
                                Créer un nouveau modèle
                            </a>
                        </div>
                    </div>
                </div>

                <div class="mt-6 flex justify-end space-x-3">
                    <a href="{{ route('motos.index') }}" class="px-4 py-2 bg-carbon-fiber hover:bg-gray-700 text-polished-chrome rounded transition-colors">Annuler</a>
                    <button type="submit" class="moto-button">Créer la moto</button>
                </div>
            </form>
        </div>
    </div>
</x-app-layout>